import { BooleanLike } from 'tgui-core/react';

export type Data = {
  mapRef: string;
  bodyrecords: bodyrecord[];
  stock_bodyrecords: string[];
  activeBodyRecord: activeBodyRecord;
  menu: string;
  temp: {
    styleHref: string;
    style: string;
    color: string | undefined;
    colorHref: string | undefined | { act: string; params: Object };
    color2?: string | undefined;
    colorHref2?: string | undefined | { act: string; params: Object };
  };
  disk: BooleanLike;
  diskStored: BooleanLike;
};

export type bodyrecord = { name: string; recref: string };

export type activeBodyRecord = {
  real_name: string;
  speciesname: string;
  gender: string;
  synthetic: string;
  locked: BooleanLike;
  booc: string;
};

type colourableStyle = {
  styleHref: string;
  style: string;
  color: string | undefined;
  colorHref: string | undefined;
  color2: string | undefined;
  colorHref2: string | undefined;
};

type simpleStyle = {
  styleHref: string;
  style: string;
  colorHref: string;
  color: string;
};

type colourStyle = {
  colorHref: string;
  color: string;
};
