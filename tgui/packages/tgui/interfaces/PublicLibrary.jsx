import { useBackend } from '../backend';
import { Box, Button, NoticeBox, LabeledList, Section } from '../components';
import { Window } from '../layouts';

export const PublicLibrary = (props, context) => {
  const { act, data } = useBackend(context);
  const { errorText, searchmode, search, title, body, ad_string1, ad_string2, print, appliance } = data;

  return (
    <Window width={900} height={600} resizable>
      <Window.Content>
        {errorText && (
          <NoticeBox warning>
            <Box display="inline-block" verticalAlign="middle">
              {errorText}
            </Box>
          </NoticeBox>
        )}
        <Section title="Bingle Search">
          {(!!searchmode && (
            <Section>
              {(!!appliance && <Button icon="arrow-left" content="Back" onClick={() => act('closeappliance')} />) || (
                <Button icon="arrow-left" content="Back" onClick={() => act('closesearch')} />
              )}
              {!!print && <Button icon="print" content="Print" onClick={() => act('print')} />}
              <Section title={title}>
                <div dangerouslySetInnerHTML={{ __html: body }} />
              </Section>
              <Section title={searchmode}>
                {search.map((Key) => (
                  <Button content={Key} onClick={() => act('search', { data: Key })} />
                ))}
              </Section>
            </Section>
          )) || (
            <Section>
              <h2>The galaxys 18th most tollerated* infocore dispenser!</h2>
              <LabeledList>
                <LabeledList.Item>
                  <Button icon="search" content="Food Recipes" onClick={() => act('foodsearch')} />
                </LabeledList.Item>
                <LabeledList.Item>
                  <Button icon="search" content="Drink Recipes" onClick={() => act('drinksearch')} />
                </LabeledList.Item>
                <LabeledList.Item>
                  <Button icon="search" content="Chemistry" onClick={() => act('chemsearch')} />
                </LabeledList.Item>
                <LabeledList.Item>
                  <Button icon="search" content="Ores" onClick={() => act('oresearch')} />
                </LabeledList.Item>
                <LabeledList.Item>
                  <Button icon="search" content="Materials" onClick={() => act('matsearch')} />
                </LabeledList.Item>
                <LabeledList.Item>
                  <Button icon="search" content="Particle Physics" onClick={() => act('smashsearch')} />
                </LabeledList.Item>
                <LabeledList.Item>
                  <Button icon="search" content="Catalogs" onClick={() => act('catalogsearch')} />
                </LabeledList.Item>
                <LabeledList.Item />
                <LabeledList.Item>
                  <Button icon="download" content={ad_string1} onClick={() => act('crash')} />
                </LabeledList.Item>
                <LabeledList.Item>
                  <Button icon="download" content={ad_string2} onClick={() => act('crash')} />
                </LabeledList.Item>
              </LabeledList>
            </Section>
          )}
        </Section>
      </Window.Content>
    </Window>
  );
};
