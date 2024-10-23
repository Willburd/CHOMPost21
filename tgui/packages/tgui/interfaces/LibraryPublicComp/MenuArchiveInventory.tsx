import { useBackend } from '../../backend';
import { Box, Button, Divider, Section } from '../../components';
import { Data } from './types';

export const MenuArchiveInventory = (props) => {
  const { act, data } = useBackend<Data>();

  const { inventory } = data;

  return (
    <Section title="Scanned Inventory">
      {inventory.length > 0 ? (
        inventory.map((book) => (
          <Section title={book.title} key={book.id}>
            {book.author} - {book.category}
            <br />
            <Button.Confirm
              icon="eye"
              onClick={() => act('quickcheck', { delbook: book.ref })}
            >
              Checkout
            </Button.Confirm>
            <Button.Confirm
              icon="eye"
              color="red"
              onClick={() => act('delbook', { delbook: book.ref })}
            >
              Delete
            </Button.Confirm>
            <Divider />
          </Section>
        ))
      ) : (
        <Box>
          <br />
          <center>
            <h2>CHECKOUT INVENTORY EMPTY</h2>
          </center>
          <br />
          <center>
            Scan books with a barcode scanner in mode 3 to add them to the
            inventory. The inventory is visible from the guest computer.
          </center>
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
