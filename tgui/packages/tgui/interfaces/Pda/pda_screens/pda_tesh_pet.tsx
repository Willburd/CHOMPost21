import { useBackend } from 'tgui/backend';
import { Box, LabeledList } from 'tgui-core/components';

type Data = {
  teshpet_data: {
    scores: Record<string, number>[];
  };
};

export const pda_prisoner_implant = (props) => {
  const { act, data } = useBackend<Data>();
  const { teshpet_data } = data;

  return (
    <Box>
      {(teshpet_data.scores && (
        <LabeledList>
          {teshpet_data.scores.map((cart, i) => (
            <LabeledList.Item key={i} label={cart.key}>
              {cart.value}
            </LabeledList.Item>
          ))}
        </LabeledList>
      )) || <Box color="bad">There are no petted tesh.</Box>}
    </Box>
  );
};
