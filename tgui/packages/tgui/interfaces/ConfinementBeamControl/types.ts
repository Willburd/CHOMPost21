import { BooleanLike } from 'common/react';

export type Data = {
  has_gen: BooleanLike;
  pulse_enable: BooleanLike;
  calibrating: BooleanLike;
  target_z: number;
  last_temp: number;
  max_temp: number;
  last_watt: string;
};
