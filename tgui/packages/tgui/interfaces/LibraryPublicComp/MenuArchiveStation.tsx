import { useBackend } from '../../backend';
import { Box, Button, Divider, Section } from '../../components';
import { Data } from './types';

export const MenuArchiveStation = (props) => {
  const { act, data } = useBackend<Data>();

  const { inventory } = data;

  return (
    <Section title="Station Archive">
      {inventory.length > 0 ? (
        inventory.map((book) => (
          <Section title={book.title} key={book.id}>
            {book.author} - {book.category}
            <br />
            <Button
              icon="eye"
              onClick={() =>
                act('import_external', { import_external: book.id })
              }
            >
              Print
            </Button>
            <Button.Confirm
              icon="eye"
              color="red"
              disabled={book.protected}
              onClick={() =>
                act('delete_external', { delete_external: book.id })
              }
            >
              {book.protected ? 'Protected' : 'Delete'}
            </Button.Confirm>
            <Divider />
          </Section>
        ))
      ) : (
        <Box>
          <br />
          <center>
            <h2>ARCHIVE EMPTY</h2>
          </center>
          <br />
          <center>Use linked scanner to upload new titles.</center>
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
