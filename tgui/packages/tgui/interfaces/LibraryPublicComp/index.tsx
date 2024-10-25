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
    <Window width={710} height={720}>
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

  let screen_menu = {
    home: <MenuHome />,
    inventory: <MenuArchiveInventory />,
    checkedout: <MenuCheckedOut />,
    checking: <MenuCheckingOut />,
    online: <MenuArchiveDownload />,
    upload: <MenuUpload />,
    arcane: <MenuArcane />,
    archive: <MenuArchiveStation />,
    publicarchive: <MenuPublicStation />,
    publiconline: <MenuPublicDownload />,
  };

  return screen_menu[screenstate] ? screen_menu[screenstate] : <MenuHome />;
};
