import { useBackend } from '../../backend';
import { Button, Divider, Section } from '../../components';
import { Data } from './types';

export const MenuCheckingOut = (props) => {
  const { act, data } = useBackend<Data>();

  const { buffer_book, buffer_mob, checkoutperiod } = data;

  return (
    <Section title="Check out a Book">
      <Button onClick={() => act('decreasetime', { decreasetime: 1 })}>
        -
      </Button>
      (Checkout Period: {checkoutperiod} minutes)
      <Button onClick={() => act('increasetime', { increasetime: 1 })}>
        +
      </Button>
      <Divider />
      <Button icon="eye" onClick={() => act('checkout', { checkout: 1 })}>
        Commit Entry
      </Button>
    </Section>
  );
};
