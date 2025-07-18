import { useBackend } from 'tgui/backend';
import { Box, Button, Section } from 'tgui-core/components';

import type { Data, modalData } from './types';

export const viewCrateContents = (modal: modalData) => {
  const { act, data } = useBackend<Data>();
  const { supply_points, price_mod, cash_points } = data; // Outpost 21 edit - Points or thalers
  const { name, cost, desc, manifest, ref, random } = modal.args;
  return (
    <Section
      width="400px"
      m="-1rem"
      pb="1rem"
      title={name}
      buttons={
        <Button
          icon="shopping-cart"
          disabled={cost > supply_points}
          onClick={() => act('request_crate', { ref: ref })}
        >
          {'Buy - ' +
            cost * (price_mod ? 1 : cash_points) +
            (price_mod === 1 ? ' points' : '₮')}
        </Button>
      }
    >
      {desc}
      <Section
        title={`Contains${random ? ` any ${random} of:` : ''}`}
        scrollable
        height="200px"
      >
        {manifest.map((m) => (
          <Box key={m}>{m}</Box>
        ))}
      </Section>
    </Section>
  );
};
