import { Box, Dimmer } from '../../components';

export const NoGen = () => {
  return (
    <Dimmer textAlign="center">
      <br />
      <Box color="average">
        <h1>&nbsp;No Generator Attached&nbsp;</h1>
      </Box>
    </Dimmer>
  );
};
