import { useBackend } from '../../backend';
import { Box, Button, Divider, Section } from '../../components';
import { MenuPageChanger } from './MenuParts';
import { Data } from './types';

export const MenuCheckedOut = (props) => {
  const { act, data } = useBackend<Data>();

  const { checks } = data;

  return (
    <Section title="Checked Out Inventory">
      {checks.length > 0 ? (
        checks.map((checkout) => (
          <Section title={checkout.bookname} key={checkout.bookname}>
            Checked out to: {checkout.bookname} <br />
            --- Taken: {checkout.timetaken} minutes ago, Due: in{' '}
            {checkout.overdue ? '(OVERDUE)' : checkout.timedue + ' minutes'}{' '}
            <br />
            <Button.Confirm
              icon="eye"
              onClick={() => act('checkin', { checkin: checkout.ref })}
            >
              Check In
            </Button.Confirm>
            <Divider />
          </Section>
        ))
      ) : (
        <Box>
          <br />
          <center>
            <h2>CHECKOUT EMPTY</h2>
          </center>
          <br />
          <center>No books are currently checked out.</center>
        </Box>
      )}
      <Divider />
      <MenuPageChanger lencheck={checks.length} />
    </Section>
  );
};
