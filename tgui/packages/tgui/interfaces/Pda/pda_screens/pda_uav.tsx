import { useBackend } from 'tgui/backend';
import { Box, Button, LabeledList } from 'tgui-core/components';
import type { BooleanLike } from 'tgui-core/react';

type Data = {
  uav_data: {
    current_uav: { status: string; power: BooleanLike } | null;
    signal_strength: string;
    in_use: BooleanLike;
  };
};

export const pda_uav = (props) => {
  const { act, data } = useBackend<Data>();
  const { current_uav, signal_strength, in_use } = data.uav_data;

  return (
    <Box>
      {current_uav ? (
        <LabeledList>
          <LabeledList.Item label="UAV">
            {current_uav?.status || '[Not Connected]'}
          </LabeledList.Item>
          <LabeledList.Item label="Signal">
            {(current_uav && signal_strength) || '[Not Connected]'}
          </LabeledList.Item>
          <LabeledList.Item label="Power">
            {(current_uav && (
              <Button
                icon="power-off"
                selected={current_uav.power}
                onClick={() => act('power_uav')}
              >
                {current_uav.power ? 'Online' : 'Offline'}
              </Button>
            )) ||
              '[Not Connected]'}
          </LabeledList.Item>
          <LabeledList.Item label="Camera">
            {(current_uav && (
              <Button
                icon="power-off"
                selected={in_use}
                disabled={!current_uav.power}
                onClick={() => act('view_uav')}
              >
                {current_uav.power ? 'Available' : 'Unavailable'}
              </Button>
            )) ||
              '[Not Connected]'}
          </LabeledList.Item>
        </LabeledList>
      ) : (
        <Box color="bad">No UAV paired.</Box>
      )}
    </Box>
  );
};
