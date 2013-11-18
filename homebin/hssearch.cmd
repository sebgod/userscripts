@setlocal enabledelayedexpansion

@pushd \\homeserver\Movies
@dir /b *%~1*
@popd

@endlocal