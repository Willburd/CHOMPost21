/* eslint react/no-danger: "off" */
import { useBackend } from 'tgui/backend';
import { Box, Button, Section } from 'tgui-core/components';

type Data = {
  sop_title: string;
  sop_body: string;
  sop_author: string;
  first: boolean;
  last: boolean;
};

export const pda_sop = (props) => {
  const { act, data } = useBackend<Data>();

  const { sop_title, sop_body, sop_author, first, last } = data;

  return (
    <Box>
      <Section title="Standard Operating Procedures">
        <Button
          disabled={first}
          icon="chevron-left"
          onClick={() => act('prev')}
        >
          Previous
        </Button>
        <Button
          disabled={last}
          icon="chevron-right"
          onClick={() => act('next')}
        >
          Next
        </Button>
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
