import { useBackend } from 'tgui/backend';
import { Window } from 'tgui/layouts';
import {
  Box,
  Button,
  Dimmer,
  Icon,
  LabeledList,
  Section,
} from 'tgui-core/components';
import type { BooleanLike } from 'tgui-core/react';

type Data = {
  auth: BooleanLike;
  yes_code: BooleanLike;
  code: string;
  safety: BooleanLike;
  timeleft: number;
  timing: BooleanLike;
  critical: BooleanLike;
  start_minutes: number;
};

export const NukeConsole = (props) => {
  const { act, data } = useBackend<Data>();
  const {
    auth,
    code,
    yes_code,
    safety,
    timeleft,
    timing,
    critical,
    start_minutes,
  } = data;
  const date = new Date(0);
  date.setSeconds(timeleft);
  const timeString = date.toISOString().substring(11, 19);
  return (
    <Window width={450} height={150}>
      <Window.Content>
        {critical ? (
          <Dimmer textAlign="center">
            <Box color="average">
              <h1>
                <Icon name="radiation" />
                &nbsp;EVACUATE {timeString} EVACUATE&nbsp;
                <Icon name="radiation" />
              </h1>
            </Box>
          </Dimmer>
        ) : (
          <Section
            title="Nuclear Warhead Control"
            buttons={
              <Button
                disabled={!auth || !safety || timing}
                icon="eject"
                onClick={() => act('ejectDisk')}
              >
                Eject Disk
              </Button>
            }
          >
            <LabeledList>
              <LabeledList.Item
                label="Arming Code"
                color={yes_code ? 'green' : 'red'}
                buttons={
                  <Button
                    disabled={!auth || timing}
                    onClick={() => act('armingCode')}
                  >
                    {yes_code ? 'Disarm' : 'Arm'} Warhead
                  </Button>
                }
              >
                {code}
              </LabeledList.Item>
              {!yes_code ? (
                <LabeledList.Item
                  label="Detonation"
                  color={safety ? 'green' : 'red'}
                  buttons={
                    <Button
                      disabled={!auth || !yes_code || timing}
                      onClick={() => act('safety')}
                    >
                      {safety ? 'SAFE' : 'ARMED'}
                    </Button>
                  }
                />
              ) : (
                <LabeledList.Item
                  label="Detonation"
                  color={safety ? 'green' : 'red'}
                  buttons={
                    <Button disabled={timing} onClick={() => act('safety')}>
                      {safety ? 'SAFE' : 'ARMED'}
                    </Button>
                  }
                >
                  {timing ? (
                    <Button disabled={!timing} onClick={() => act('abort')}>
                      {`${timeString} REMAINING - ABORT?`}
                    </Button>
                  ) : (
                    <>
                      <Button
                        disabled={!auth || timing || safety}
                        onClick={() => act('time')}
                      >
                        {start_minutes} Minutes
                      </Button>
                      <Button
                        disabled={!auth || timing || safety}
                        onClick={() => act('timer')}
                      >
                        Begin Countdown
                      </Button>
                    </>
                  )}
                </LabeledList.Item>
              )}
            </LabeledList>
          </Section>
        )}
      </Window.Content>
    </Window>
  );
};
