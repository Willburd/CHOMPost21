import { useBackend } from '../../backend';
import { Box, Button } from '../../components';
import { Window } from '../../layouts';
import { BodyDesignerBodyRecords } from './BodyDesignerBodyRecords';
import { BodyDesignerMain } from './BodyDesignerMain';
import { BodyDesignerOOCNotes } from './BodyDesignerOOCNotes';
import { BodyDesignerSpecificRecord } from './BodyDesignerSpecificRecord';
import { BodyDesignerStockRecords } from './BodyDesignerStockRecords';
import { Data } from './types';

export const BodyDesigner = (props) => {
  const { act, data } = useBackend<Data>();

  const {
    menu,
    disk,
    diskStored,
    activeBodyRecord,
    stock_bodyrecords,
    bodyrecords,
    mapRef,
  } = data;

  const MenuToTemplate = {
    Main: <BodyDesignerMain />,
    'Body Records': <BodyDesignerBodyRecords bodyrecords={bodyrecords} />,
    'Stock Records': (
      <BodyDesignerStockRecords stock_bodyrecords={stock_bodyrecords} />
    ),
    'Specific Record': (
      <BodyDesignerSpecificRecord
        activeBodyRecord={activeBodyRecord}
        mapRef={mapRef}
      />
    ),
    'OOC Notes': <BodyDesignerOOCNotes activeBodyRecord={activeBodyRecord} />,
  };

  let body = MenuToTemplate[menu];

  return (
    <Window width={750} height={850}> { /* Outpost 21 edit - Larger window for less scrolling */ }
      <Window.Content>
      { /* Outpost 21 edit begin - Disk button always visible */ }
        <Box>
          <Button
            icon="save"
            onClick={() => act('savetodisk')}
            disabled={!disk || !activeBodyRecord} // Outpost 21 edit - They just disable instead!
          >
            Save To Disk
          </Button>
          <Button
            icon="save"
            onClick={() => act('loadfromdisk')}
            disabled={!disk || !diskStored} // Outpost 21 edit - They just disable instead!
          >
            Load From Disk
          </Button>
          <Button icon="eject" onClick={() => act('ejectdisk')} disabled={!disk} > { /* Outpost 21 edit - They just disable instead! */ }
            Eject
          </Button>
        </Box>
        { /* Outpost 21 edit end */ }
        {body}
      </Window.Content>
    </Window>
  );
};
