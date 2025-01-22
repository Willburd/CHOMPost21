import { useBackend } from '../../backend';
import { Button } from '../../components';
import { Window } from '../../layouts';
import { Calibrating } from './Calibrating';
import { NoGen } from './NoGen';
import { Data } from './types';

export const DNAModifier = (props) => {
  const { act, data } = useBackend<Data>();

  const { has_gen, pulse_enable, calibrating, target_z } = data;

  return (
    <Window width={660} height={870}>
      {calibrating ? (
        <Calibrating />
      ) : !has_gen ? (
        <NoGen />
      ) : (
        <Window.Content className="Layout__content--flexColumn">
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
        </Window.Content>
      )}
    </Window>
  );
};
