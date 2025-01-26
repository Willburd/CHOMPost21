import { Box, Dimmer, Icon } from 'tgui-core/components';

export const Calibrating = () => {
  return (
    <Dimmer textAlign="center">
      <Icon name="spinner" size={5} spin />
      <br />
      <Box color="average">
        <h1>
          <Icon name="atom" />
          &nbsp;Calibrating Beam&nbsp;
          <Icon name="atom" />
        </h1>
      </Box>
    </Dimmer>
  );
};
