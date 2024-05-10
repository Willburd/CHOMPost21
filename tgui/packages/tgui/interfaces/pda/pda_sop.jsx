/* eslint react/no-danger: "off" */
import { useBackend } from '../../backend';
import { Box, Button, Section } from '../../components';

export const pda_sop = (props, context) => {
  const { act, data } = useBackend(context);

  const { sop_title, sop_body, sop_author, first, last } = data;

  return (
    <Box>
      <Section title="Standard Operating Procedures">
        <Button disabled={first} icon="chevron-left" onClick={() => act('prev')} content="Previous" />
        <Button disabled={last} icon="chevron-right" onClick={() => act('next')} content="Next" />
        <Section title={sop_title}>
          {/* Uses dangerouslySetInnerHTML, This likely needs more sanitization, but it's not editable by players anyway? */}
          <div dangerouslySetInnerHTML={{ __html: sop_body }} />
          <br />
          <hr />
          <br />
          {sop_author}
        </Section>
      </Section>
    </Box>
  );
};
