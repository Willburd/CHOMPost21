/**
 * @file
 * @copyright 2020 Aleksej Komarov
 * @license MIT
 */

export const SETTINGS_TABS = [
  {
    id: 'general',
    name: 'General',
  },
  {
    id: 'adminSettings',
    name: 'Admin',
  },
  {
    id: 'limits',
    name: 'Visual Limits',
  },
  {
    id: 'export',
    name: 'Export',
  },
  {
    id: 'textHighlight',
    name: 'Text Highlights',
  },
  {
    id: 'chatPage',
    name: 'Chat Tabs',
  },
  {
    id: 'statPanel',
    name: 'Stat Panel',
  },
  {
    id: 'ttsSettings',
    name: 'TTS/Accessibility',
  },
];

export const FONTS_DISABLED = 'Default';

export const FONTS = [
  FONTS_DISABLED,
  'Verdana',
  'Arial',
  'Arial Black',
  'Comic Sans MS',
  'Impact',
  'Lucida Sans Unicode',
  'Tahoma',
  'Trebuchet MS',
  'Courier New',
  'Lucida Console',
];

export const MAX_HIGHLIGHT_SETTINGS = 10;

export const blacklisted_tags = ['a', 'iframe', 'link', 'video'];
