import { useBackend } from 'tgui/backend';
import { Window } from 'tgui/layouts';
import {
  Button,
  Chart,
  Knob,
  LabeledList,
  ProgressBar,
  Section,
  Stack,
} from 'tgui-core/components';

import { Calibrating } from './Calibrating';
import { NoGen } from './NoGen';
import type { Data } from './types';

export const ConfinementBeamControl = (props) => {
  const { act, data } = useBackend<Data>();

  const {
    has_gen,
    pulse_enable,
    calibrating,
    target_z,
    history,
    last_temp,
    max_temp,
    last_watt,
    target_list,
    current_target,
    last_health,
    max_health,
    t_rate,
  } = data;

  const heatData: number[][] = history.current.map((value, i) => [i, value]);
  const maxHeatData: number[][] = history.maximum.map((value, i) => [i, value]);

  return (
    <Window width={460} height={570}>
      <Window.Content>
        {calibrating ? (
          <Calibrating />
        ) : !has_gen ? (
          <NoGen />
        ) : (
          <>
            <Section title="Beam Control">
              {pulse_enable ? (
                <Button
                  disabled={calibrating || !has_gen || target_z === -1}
                  onClick={() => act('toggle_beam')}
                >
                  SHUTDOWN
                </Button>
              ) : (
                <Button.Confirm
                  disabled={calibrating || !has_gen || target_z === -1}
                  onClick={() => act('toggle_beam')}
                >
                  ENGAGE BEAM
                </Button.Confirm>
              )}
              <LabeledList>
                <LabeledList.Item label="Target Collector">
                  {current_target}
                </LabeledList.Item>
                <LabeledList.Item label="Wattage">{last_watt}</LabeledList.Item>
                <LabeledList.Item label="Intensity">
                  <Knob
                    minValue={0}
                    maxValue={100}
                    stepPixelSize={2}
                    value={t_rate}
                    ml="0"
                    onChange={(e, val) =>
                      act('transmission_rate', { value: val })
                    }
                  />
                </LabeledList.Item>
              </LabeledList>
            </Section>
            <Section title="Focus">
              <Stack mx={-0.5} mb={1} fill>
                <Stack.Item mx={0.5} width="200px">
                  <LabeledList>
                    <LabeledList.Item label="Stability">
                      <ProgressBar
                        minValue={0}
                        maxValue={1}
                        value={last_health / max_health}
                        color={last_health < max_health * 0.45 ? 'bad' : 'good'}
                        mr="0.5rem"
                      >
                        {(last_health / max_health) * 100}%
                      </ProgressBar>
                    </LabeledList.Item>
                    <LabeledList.Item label="Temperature">
                      <ProgressBar
                        minValue={0}
                        maxValue={1}
                        value={last_temp / max_temp}
                        color="bad"
                        mr="0.5rem"
                      >
                        {last_temp}K
                      </ProgressBar>
                    </LabeledList.Item>
                  </LabeledList>
                </Stack.Item>
                <Stack.Item mx={0.5} grow>
                  <Section position="relative" fill>
                    <Chart.Line
                      fillPositionedParent
                      data={heatData}
                      rangeX={[0, heatData.length - 1]}
                      rangeY={[0, max_temp * 1.4]}
                      strokeColor="rgb(211, 73, 13)"
                      fillColor="rgba(224, 57, 151, 0.25)"
                    />
                    <Chart.Line
                      fillPositionedParent
                      data={maxHeatData}
                      rangeX={[0, maxHeatData.length - 1]}
                      rangeY={[0, max_temp * 1.4]}
                      strokeColor="rgb(255, 0, 0)"
                      fillColor="rgba(0, 0, 0, 0)"
                    />
                  </Section>
                </Stack.Item>
              </Stack>
            </Section>
            <Section title="Beam Targets" fill scrollable>
              <Button
                disabled={calibrating || !has_gen || target_z === -1}
                onClick={() => act('set_z', { id: '' })}
              >
                Release Target
              </Button>
              <Stack>
                {target_list.map((value) => (
                  <Stack.Item key={value.id}>
                    <Button
                      disabled={
                        calibrating || !has_gen || !value.enb || target_z !== -1
                      }
                      onClick={() =>
                        act('set_z', {
                          id: value.id,
                          x: value.x,
                          y: value.y,
                          z: value.z,
                        })
                      }
                    >
                      {value.id}
                    </Button>
                  </Stack.Item>
                ))}
              </Stack>
            </Section>
          </>
        )}
      </Window.Content>
    </Window>
  );
};
