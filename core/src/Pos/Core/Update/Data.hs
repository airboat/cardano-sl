module Pos.Core.Update.Data
       ( UpdateData (..)
       ) where

import           Universum

import qualified Data.Text.Buildable as Buildable
import           Formatting (bprint, build, (%))

import           Pos.Binary.Class (Raw)
import           Pos.Crypto (Hash)

-- | Data which describes update. It is specific for each system.
data UpdateData = UpdateData
    { udAppDiffHash  :: !(Hash Raw)
    -- ^ Hash of binary diff between two applications. This diff can
    -- be passed to updater to create new application.
    , udPkgHash      :: !(Hash Raw)
    -- ^ Hash of package to install new application. This package can
    -- be used to install new application from scratch instead of
    -- updating existing application.
    , udUpdaterHash  :: !(Hash Raw)
    -- ^ Hash if update application which can be used to install this
    -- update (relevant only when updater is used, not package).
    , udMetadataHash :: !(Hash Raw)
    -- ^ Hash of metadata relevant to this update.  It is raw hash,
    -- because metadata can include image or something
    -- (maybe). Anyway, we can always use `unsafeHash`.
    } deriving (Eq, Show, Generic, Typeable)

instance NFData UpdateData

instance Hashable UpdateData

instance Buildable UpdateData where
    build UpdateData {..} =
      bprint ("{ appDiff: "%build%
              ", pkg: "%build%
              ", updater: "%build%
              ", metadata: "%build%
              " }")
        udAppDiffHash
        udPkgHash
        udUpdaterHash
        udMetadataHash
