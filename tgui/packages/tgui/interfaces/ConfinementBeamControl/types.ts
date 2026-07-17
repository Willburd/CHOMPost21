import type { BooleanLike } from 'tgui-core/react';

export type Data = {
  has_gen: BooleanLike;
  pulse_enable: BooleanLike;
  calibrating: BooleanLike;
  target_z: number;
  history: { current: number[]; maximum: number[]; health: number[] };
  last_temp: number;
  max_temp: number;
  last_watt: string;
  target_list: BeamTarget[];
  current_target: string;
  last_health: number;
  max_health: number;
  t_rate: number;
};

export type BeamTarget = {
  id: string;
  x: number;
  y: number;
  z: number;
  enb: BooleanLike;
};
