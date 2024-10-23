import { useBackend } from '../../backend';
import { Box, Button, Divider, Section } from '../../components';
import { Data } from './types';

export const MenuArchiveDownload = (props) => {
  const { act, data } = useBackend<Data>();

  const { inventory } = data;

  return (
    <Section title="Browsing Exonet">
      {inventory.length > 0 ? (
        inventory.map((book) => (
          <Section title={book.title} key={book.id}>
            {book.author} - {book.category}
            <br />
            <Button
              icon="eye"
              onClick={() => act('hardprint', { hardprint: book.type })}
            >
              Print
            </Button>
            <Divider />
          </Section>
        ))
      ) : (
        <Box>
          <br />
          <center>
            <h2>CANNOT CONNECT</h2>
          </center>
          <br />
          <center>Exonet archive could not be reached.</center>
        </Box>
      )}
      <Divider />
      <Button
        icon="eye"
        disabled={inventory.length === 0}
        onClick={() => act('inv_prev', { inv_prev: 1 })}
      >
        Prev
      </Button>
      <Button
        icon="eye"
        disabled={inventory.length === 0}
        onClick={() => act('inv_nex', { inv_nex: 1 })}
      >
        Next
      </Button>
    </Section>
  );
};
