import { Box, Dimmer, Icon } from '../../components';

export const Calibrating = () => {
  return (
    <Dimmer textAlign="center">
      <Icon name="spinner" size={5} spin />
      <br />
      <Box color="average">
        <h1>
          <Icon name="radiation" />
          &nbsp;Calibrating Beam&nbsp;
          <Icon name="radiation" />
        </h1>
      </Box>
    </Dimmer>
  );
};
