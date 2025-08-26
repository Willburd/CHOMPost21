import { useBackend } from 'tgui/backend';
import { Box, LabeledList } from 'tgui-core/components';

type Data = {
  security: {
    prisoner_implants:
      | {
          host: string;
          x: number;
          y: number;
          z: number;
          area: string;
        }[]
      | null;
  };
};

export const pda_prisoner_implant = (props) => {
  const { act, data } = useBackend<Data>();
  const { security } = data;

  return (
    <Box>
      {(security.prisoner_implants && (
        <LabeledList>
          {security.prisoner_implants.map((cart, i) => (
            <LabeledList.Item key={i} label={cart.host}>
              {cart.area} - {cart.x}.{cart.z}.{cart.z}
            </LabeledList.Item>
          ))}
        </LabeledList>
      )) || <Box color="bad">There are no implanted prisoners</Box>}
    </Box>
  );
};
