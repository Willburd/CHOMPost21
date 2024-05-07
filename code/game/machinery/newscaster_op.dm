//##############################################
//################### FILE LOADED NEWS HERE ####
//##############################################

/datum/feed_message/load_from_file // loaded feeds from server files
	author = "Error"
	backup_author = "Error"
	title = "Malformed Header"
	body = "Unable to load."
	backup_body = "Unable to load."

/datum/feed_message/load_from_file/New(var/list/json_data)
	..()
	author = json_data["author"]
	title = json_data["title"]
	body = json_data["body"]
	message_type = json_data["message_type"]
	time_stamp = "[stationtime2text()]"

/datum/feed_channel/load_from_file
	channel_name="remember to set your name!"
	announcement = null

/datum/feed_channel/load_from_file/New(var/server_file_path,var/datum/feed_network/net)
	// File path to HTML file that will be loaded on server start. Example: 'news_feed/filename.html'. Use the /news_feed/ folder!
	..()
	var/stored_data = file2text(server_file_path)
	var/list/json_data = json_decode(stored_data)
	if(json_data && json_data.len)
		log_world("len: [json_data.len]")
		var/i = 0
		while(i++ < json_data.len)
			var/list/subjson = json_data[i]
			var/datum/feed_message/load_from_file/scanmessage = new(subjson)
			log_world(" -[subjson["title"]] created from json at index [i]")
			net.insert_message_in_channel(src, scanmessage) //Adding message to the network's appropriate feed_channel

/datum/feed_network/proc/CreateFeedChannel_FromFile(var/channel_name, var/author, var/server_file_path)
	log_world("News channel created from file [channel_name].[server_file_path]")
	var/datum/feed_channel/load_from_file/newChannel = new /datum/feed_channel/load_from_file(server_file_path,src)
	newChannel.channel_name = channel_name
	newChannel.author = author
	newChannel.locked = TRUE
	newChannel.is_admin_channel = TRUE
	network_channels += newChannel
