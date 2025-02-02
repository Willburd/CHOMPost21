import { useBackend } from 'tgui/backend';
import { Button, Section } from 'tgui-core/components';

import { Data } from './types';

export const BodyDesignerBodyRecords = () => {
  const { act, data } = useBackend<Data>();
  const { bodyrecords, stock_bodyrecords } = data;
  return (
    <Section title="Bodyrecord Database">
      <Section
        title="Stock Records"
        buttons={
          <Button
            icon="arrow-left"
            onClick={() => act('menu', { menu: 'Main' })}
          >
            Back
          </Button>
        }
      >
        {stock_bodyrecords.map((record) => (
          <Button
            icon="eye"
            key={record}
            onClick={() => act('view_stock_brec', { view_stock_brec: record })}
          >
            {record}
          </Button>
        ))}
      </Section>
      <Section
        title="Crew Records"
        buttons={
          <Button
            icon="arrow-left"
            onClick={() => act('menu', { menu: 'Main' })}
          >
            Back
          </Button>
        }
      >
        {bodyrecords
          ? bodyrecords.map((record) => (
              <Button
                icon="eye"
                key={record.name}
                onClick={() => act('view_brec', { view_brec: record.recref })}
              >
                {record.name}
              </Button>
            ))
          : ''}
      </Section>
    </Section>
  );
};
