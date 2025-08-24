import { useBackend } from 'tgui/backend';
import { Box, LabeledList, Section } from 'tgui-core/components';

type Data = {
  security: {
    prisoner_implants:
      | {
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
      <Section title="Tracking Implants">
        {(security.prisoner_implants && (
          <LabeledList>
            {security.prisoner_implants.map((cart, i) => (
              <LabeledList.Item key={i} label={cart.area}>
                {cart.x}.{cart.z}.{cart.z}
              </LabeledList.Item>
            ))}
          </LabeledList>
        )) || <Box color="bad">There are no implanted prisoners</Box>}
      </Section>
    </Box>
  );
};
