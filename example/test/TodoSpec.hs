{-# OPTIONS_GHC -fno-warn-orphans #-}
module TodoSpec where

import Control.Applicative
import Data.Aeson
import qualified Data.ByteString.Lazy.Char8 as BL8
import Servant.Swagger.Test
import Test.Hspec
import Test.QuickCheck
import Test.QuickCheck.Instances ()
import Todo
import Paths_example

spec :: Spec
spec = describe "Swagger" $ do
  context "ToJSON matches ToSchema" $ validateEveryToJSON todoAPI
  it "swagger.json is up-to-date" $ do
    path <- getDataFileName "swagger.json"
    swag <- eitherDecode <$> BL8.readFile path
    swag `shouldBe` Right todoSwagger

instance Arbitrary Todo where
  arbitrary = Todo <$> arbitrary <*> arbitrary

instance Arbitrary TodoId where
  arbitrary = TodoId <$> arbitrary