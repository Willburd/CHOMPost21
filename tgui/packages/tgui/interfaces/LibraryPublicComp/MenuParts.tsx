import { useBackend } from '../../backend';
import { Button } from '../../components';
import { Data } from './types';

export const MenuPageChanger = (props, lencheck) => {
  const { act, data } = useBackend<Data>();

  const { inv_left, inv_right } = data;

  return lencheck === 0 || (inv_left === false && inv_right === false) ? (
    ''
  ) : (
    <center>
      <Button
        icon="eye"
        disabled={!inv_left}
        onClick={() => act('inv_prev', { inv_prev: 1 })}
      >
        Prev
      </Button>
      <Button
        icon="eye"
        disabled={!inv_right}
        onClick={() => act('inv_nex', { inv_nex: 1 })}
      >
        Next
      </Button>
    </center>
  );
};
