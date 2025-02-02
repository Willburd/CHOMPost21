import { useBackend } from 'tgui/backend';
import {
  Box,
  Button,
  ByondUi,
  LabeledList,
  Section,
  Stack,
} from 'tgui-core/components';

import { activeBodyRecord } from './types';

export const BodyDesignerSpecificRecord = (props: {
  activeBodyRecord: activeBodyRecord;
  mapRef: string;
}) => {
  const { act } = useBackend();
  const { activeBodyRecord, mapRef } = props;
  return activeBodyRecord ? (
    <Stack vertical>
      <Section
        title="Specific Record"
        buttons={
          <Button
            icon="arrow-left"
            onClick={() => act('menu', { menu: 'Main' })}
          >
            Back
          </Button>
        }
      >
        <Stack.Item basis="175px">
          <Stack.Item basis="130px">
            <ByondUi
              style={{
                width: '100%',
                height: '128px',
              }}
              params={{
                id: mapRef,
                type: 'map',
              }}
            />
          </Stack.Item>
        </Stack.Item>
      </Section>
      <Stack.Item>
        <Stack>
          <Stack.Item>
            <Section title="General">
              <LabeledList>
                <LabeledList.Item label="Name">
                  <Button
                    icon="pen"
                    disabled={
                      activeBodyRecord.locked === 1 ||
                      activeBodyRecord.synthetic === 'Yes'
                    }
                    onClick={() => act('name')}
                  >
                    {activeBodyRecord.real_name}
                  </Button>
                </LabeledList.Item>
                <LabeledList.Item label="Mind Compat">
                  {activeBodyRecord.locked ? 'Low' : 'High'}
                  <Button
                    ml={1}
                    icon="eye"
                    disabled={!activeBodyRecord.booc}
                    onClick={() => act('boocnotes')}
                  >
                    View OOC Notes
                  </Button>
                </LabeledList.Item>
                <LabeledList.Item label="Synthetic">
                  {activeBodyRecord.synthetic}
                </LabeledList.Item>
                <LabeledList.Item label="Unique Identifiers">
                  <Button
                    ml={1}
                    icon="dna"
                    disabled={
                      activeBodyRecord.locked === 1 ||
                      activeBodyRecord.synthetic === 'Yes'
                    }
                    onClick={() => act('edit_body')}
                  >
                    Customize Sleeve
                  </Button>
                </LabeledList.Item>
              </LabeledList>
            </Section>
          </Stack.Item>
        </Stack>
      </Stack.Item>
    </Stack>
  ) : (
    <Box color="bad">ERROR: Record Not Found!</Box>
  );
};
