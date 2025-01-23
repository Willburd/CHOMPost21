import { useBackend } from '../../backend';
import {
  Button,
  LabeledList,
  ProgressBar,
  Section,
  Knob,
} from '../../components';
import { Window } from '../../layouts';
import { Calibrating } from './Calibrating';
import { NoGen } from './NoGen';
import { Data } from './types';

export const ConfinementBeamControl = (props) => {
  const { act, data } = useBackend<Data>();

  const {
    has_gen,
    pulse_enable,
    calibrating,
    target_z,
    last_temp,
    max_temp,
    last_watt,
    target_list,
    current_target,
    last_health,
    max_health,
    t_rate,
  } = data;

  return (
    <Window width={660} height={870}>
      {calibrating ? (
        <Calibrating />
      ) : !has_gen ? (
        <NoGen />
      ) : (
        <Window.Content className="Layout__content--flexColumn">
          <Section title="Beam Control" height="190px">
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
              <LabeledList.Item label="Focus Temperature">
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
              <LabeledList.Item label="Focus Stability">
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
            </LabeledList>
          </Section>
          <Section title="Beam Targets" flexGrow>
            <Button
              disabled={calibrating || !has_gen || target_z === -1}
              onClick={() => act('set_z', { id: '' })}
            >
              Release Target
            </Button>
            <LabeledList>
              {target_list.map((dat, i) => (
                <LabeledList.Item label={dat.id}>
                  <Button.Confirm
                    disabled={
                      calibrating || !has_gen || !dat.enb || target_z !== -1
                    }
                    onClick={() =>
                      act('set_z', { id: dat.id, x: dat.x, y: dat.y, z: dat.z })
                    }
                  >
                    Set
                  </Button.Confirm>
                </LabeledList.Item>
              ))}
            </LabeledList>
          </Section>
        </Window.Content>
      )}
    </Window>
  );
};
