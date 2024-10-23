import { useBackend } from '../../backend';
import { Box, Button, Section } from '../../components';
import { Data } from './types';

export const LibraryMainMenu = (props) => {
  const { act, data } = useBackend<Data>();

  const menu_entries_checkout = [
    ['Scanned Inventory', 'inventory'],
    ['Checkout a Book', 'checking'],
    ['Checkout Status', 'checkedout'],
  ];
  const menu_entries_archive = [
    ['Upload New Title to Archive', 'upload'],
    ['Access Station Archive', 'archive'],
    ['Download Books Online', 'online'],
  ];
  let menu_entries_misc = [['Print a Bible', 'bible']];
  if (data.emagged) {
    let arcane_misc = [['Forbidden Lore Vault', 'arcane']];
    menu_entries_misc = [...menu_entries_misc, ...arcane_misc];
  }

  return (
    <Section>
      <Section title="Checkout System">
        {menu_entries_checkout.map((entry) => (
          <Box key={entry[0]}>
            <Button
              icon="eye"
              onClick={() => act('switchscreen', { switchscreen: entry[1] })}
            >
              {entry[0]}
            </Button>
          </Box>
        ))}
      </Section>
      <Section title="Printable Archive">
        {menu_entries_archive.map((entry) => (
          <Box key={entry[0]}>
            <Button
              icon="eye"
              onClick={() => act('switchscreen', { switchscreen: entry[1] })}
            >
              {entry[0]}
            </Button>
          </Box>
        ))}
      </Section>
      <Section title="Misc">
        {menu_entries_misc.map((entry) => (
          <Box key={entry[0]}>
            <Button
              icon="eye"
              onClick={() => act('switchscreen', { switchscreen: entry[1] })}
            >
              {entry[0]}
            </Button>
          </Box>
        ))}
      </Section>
    </Section>
  );
};
