import { useBackend } from 'tgui/backend';
import {
  Box,
  Button,
  ByondUi,
  LabeledList,
  Section,
  Stack,
} from 'tgui-core/components';
import { capitalize } from 'tgui-core/string';

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
          <Stack.Item basis="48%">
            <Section title="General">
              <LabeledList>
                <LabeledList.Item label="Name">
                  <Button
                    icon="pen"
                    disabled={activeBodyRecord.locked === 1}
                    onClick={() =>
                      act('edit_tag', {
                        target_href: 'rename',
                        target_value: 1,
                      })
                    }
                  >
                    {activeBodyRecord.real_name}
                  </Button>
                </LabeledList.Item>
                <LabeledList.Item label="Species">
                  <Button
                    icon="pen"
                    disabled={activeBodyRecord.locked === 1}
                    onClick={() =>
                      act('edit_tag', {
                        target_href: 'custom_species',
                        target_value: 1,
                      })
                    }
                  >
                    {activeBodyRecord.speciesname}
                  </Button>
                </LabeledList.Item>
                <LabeledList.Item label="Bio. Sex">
                  <Button
                    icon="pen"
                    disabled={activeBodyRecord.locked === 1}
                    onClick={() =>
                      act('edit_tag', {
                        target_href: 'bio_gender',
                        target_value: 1,
                      })
                    }
                  >
                    {capitalize(activeBodyRecord.gender)}
                  </Button>
                </LabeledList.Item>
                <LabeledList.Item label="Synthetic">
                  {activeBodyRecord.synthetic}
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
                <LabeledList.Item label="Unique Identifiers">
                  <Button
                    ml={1}
                    icon="dna"
                    disabled={activeBodyRecord.locked === 1}
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
