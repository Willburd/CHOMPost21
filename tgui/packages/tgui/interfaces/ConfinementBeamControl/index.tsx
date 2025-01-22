import { useBackend } from '../../backend';
import { Button, LabeledList, ProgressBar, Section } from '../../components';
import { Window } from '../../layouts';
import { Calibrating } from './Calibrating';
import { NoGen } from './NoGen';
import { Data } from './types';

export const DNAModifier = (props) => {
  const { act, data } = useBackend<Data>();

  const {
    has_gen,
    pulse_enable,
    calibrating,
    target_z,
    last_temp,
    max_temp,
    last_watt,
  } = data;

  return (
    <Window width={660} height={870}>
      {calibrating ? (
        <Calibrating />
      ) : !has_gen ? (
        <NoGen />
      ) : (
        <Window.Content className="Layout__content--flexColumn">
          <Section title="Beam Control" flexGrow>
            <LabeledList>
              <LabeledList.Item label="Wattage">{last_watt}</LabeledList.Item>
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
            </LabeledList>
            {pulse_enable ? (
              <Button
                disabled={calibrating || !has_gen || target_z === -1}
                onClick={() => act('toggle_beam')}
              >
                Shutdown
              </Button>
            ) : (
              <Button.Confirm
                disabled={calibrating || !has_gen || target_z === -1}
                onClick={() => act('toggle_beam')}
              >
                ENGAGE BEAM
              </Button.Confirm>
            )}
          </Section>
        </Window.Content>
      )}
    </Window>
  );
};
