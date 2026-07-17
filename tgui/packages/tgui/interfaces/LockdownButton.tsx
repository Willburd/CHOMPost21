import { useBackend } from 'tgui/backend';
import { Window } from 'tgui/layouts';
import { Box, Button, Section, Stack } from 'tgui-core/components';
import type { BooleanLike } from 'tgui-core/react';

type Data = {
  unlocked: BooleanLike;
  buttons: Record<string, string>;
  door_states: Record<string, BooleanLike>;
};

export const LockdownButton = (props) => {
  const { act, data } = useBackend<Data>();
  const { unlocked, buttons, door_states } = data;

  return (
    <Window width={500} height={260}>
      <Window.Content>
        <Section fill title="Lockdown Control Console">
          {!unlocked ? (
            <Box><center>Swipe ID card to unlock.</center></Box>
          ) : (
            <Stack wrap="wrap">
              {Object.entries(buttons).map(([button, tooltip]) => (
                <Stack.Item basis="32%" key={button}>
                  <Button
                    width="100%"
                    tooltip={tooltip}
                    color={door_states[button] ? 'yellow' : 'good'}
                    onClick={() =>
                      act('triggerevent', { triggerevent: button })
                    }
                  >
                    {button}
                  </Button>
                </Stack.Item>
              ))}
            </Stack>
          )}
        </Section>
      </Window.Content>
    </Window>
  );
};
