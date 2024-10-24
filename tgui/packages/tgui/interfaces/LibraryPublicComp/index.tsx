import { Window } from 'tgui/layouts';
import { Flex } from 'tgui-core/components';

import { useBackend } from '../../backend';
import { LibraryMainMenu } from './Menu';
import { MenuArcane } from './MenuArcane';
import { MenuArchiveDownload } from './MenuArchiveDownload';
import { MenuArchiveInventory } from './MenuArchiveInventory';
import { MenuArchiveStation } from './MenuArchiveStation';
import { MenuCheckedOut } from './MenuCheckedOut';
import { MenuCheckingOut } from './MenuCheckingOut';
import { MenuHome } from './MenuHome';
import { MenuPublicDownload } from './MenuPublicDownload';
import { MenuPublicStation } from './MenuPublicStation';
import { MenuUpload } from './MenuUpload';
import { Data } from './types';

export const LibraryPublicComp = (props) => {
  const { act, data } = useBackend<Data>();

  return (
    <Window width={730} height={670}>
      <Window.Content>
        <Flex>
          <Flex.Item basis="33%">
            <LibraryMainMenu />
          </Flex.Item>
          <Flex.Item basis="66%">
            <MenuPage />
          </Flex.Item>
        </Flex>
      </Window.Content>
    </Window>
  );
};

const MenuPage = (props) => {
  const { act, data } = useBackend<Data>();
  const { screenstate } = data;

  let screen_menu = '';
  switch (screenstate) {
    default:
    case 'home':
      return <MenuHome />;
    case 'inventory':
      return <MenuArchiveInventory />;
    case 'checkedout':
      return <MenuCheckedOut />;
    case 'checking':
      return <MenuCheckingOut />;
    case 'online':
      return <MenuArchiveDownload />;
    case 'upload':
      return <MenuUpload />;
    case 'arcane':
      return <MenuArcane />;
    case 'archive':
      return <MenuArchiveStation />;
    case 'publicarchive':
      return <MenuPublicStation />;
    case 'publiconline':
      return <MenuPublicDownload />;
  }
};
