import { BooleanLike } from 'common/react';

export type Data = {
  has_gen: BooleanLike;
  pulse_enable: BooleanLike;
  calibrating: BooleanLike;
  target_z: number;
};
