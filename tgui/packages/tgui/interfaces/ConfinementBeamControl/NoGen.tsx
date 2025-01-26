import { Box, Dimmer, Icon } from 'tgui-core/components';

export const NoGen = () => {
  return (
    <Dimmer textAlign="center">
      <br />
      <Box color="average">
        <Icon name="screwdriver-wrench" />
        <h1>&nbsp;No Generator Attached&nbsp;</h1>
        <Icon name="screwdriver-wrench" />
      </Box>
    </Dimmer>
  );
};
