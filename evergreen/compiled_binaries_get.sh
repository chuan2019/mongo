DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" > /dev/null 2>&1 && pwd)"
. "$DIR/prelude.sh"

cd src

set -o errexit
set -o verbose

setup_db_contrib_tool_venv
activate_db_contrib_tool_venv

rm -rf /data/install dist-test/bin

edition="${multiversion_edition}"
platform="${multiversion_platform}"
architecture="${multiversion_architecture}"

if [ ! -z "${multiversion_edition_42_or_later}" ]; then
  edition="${multiversion_edition_42_or_later}"
fi
if [ ! -z "${multiversion_platform_42_or_later}" ]; then
  platform="${multiversion_platform_42_or_later}"
fi
if [ ! -z "${multiversion_architecture_42_or_later}" ]; then
  architecture="${multiversion_architecture_42_or_later}"
fi

if [ ! -z "${multiversion_edition_44_or_later}" ]; then
  edition="${multiversion_edition_44_or_later}"
fi
if [ ! -z "${multiversion_platform_44_or_later}" ]; then
  platform="${multiversion_platform_44_or_later}"
fi
if [ ! -z "${multiversion_architecture_44_or_later}" ]; then
  architecture="${multiversion_architecture_44_or_later}"
fi

# This is primarily for tests for infrastructure which don't always need the latest
# binaries.
db-contrib-tool setup-repro-env \
  --installDir /data/install \
  --linkDir dist-test/bin \
  --edition $edition \
  --platform $platform \
  --architecture $architecture \
  master
