# Clean Architecture
My take on Uncle Bob's clean architecture in Swift.

*There are two example projects:*
- **Example** (no asynchronous events, everything returns immediately)
- **RxExample** (asynchronous)

The workspaces are comprised of 5 main frameworks with each service having an additional framework and each platform having an additional app.

## Entity (Framework)
Defines common object structure.

Examples: `Location`, `User`, `UserList`

Unit tests not needed unless files provide helper methods.

## UseCase (Framework)
Imports `Entity`

Defines Interface of `DataProvider`'s

Owns business rules (or domain logic), calling `DataProvider` for information.

Examples: `GetLocationUseCase`, `GetUserListUseCase`, `GetUserDetailsUseCase`

Unit tested with mock `DataProvider`.

## DataProvider (Framework)
Imports `UseCase`

Imports `Entity`

Defines Interface of `Service`'s

Provides data to facilitate the use case.

May call multiple services to achieve goal. For example, a `UserListProvider` may check `StorageService` first before calling `ApiService`, if `ApiService` succeeds then a `UserList` is passed back to `StorageService` and the `UserList` is returned.

Example(s): `UserListProvider`, `LocationProvider`

Unit tested with mock `Service`.

## DataTransformer (Framework)
Imports `...Service`

Imports `Entity`

Transforms or maps data from one structure to another.

Examples(s): `UserJsonTransformer`, `UserRealmTransformer`, `LocationCLLocationTransformer`

Unit tested.

## Service (Framework for Each)
Imports `DataProvider`

Imports `Entity`

Defines Interface of `DataTransformer`

Implementation of a **single** service, calls `DataTransformer` to mutate between data type (i.e. `Realm`, `CLLocation`, `SQL`) and `Entity`.

Example(s): `ApiService`, `LocationService`, `StorageService`

Unit tested with mock `DataTransformer`.

## Presentation (Framework)
Imports `Entity`

Imports `UseCase`

### Presenter (MVP)

Defines Interface of `View`

Defines Interface of `Navigator`

Shows `Entity` data from `UseCase` on `View`.

Navigates between `Presenter`'s using `Navigator`.

Example(s): `UserListPresenter`, `UserDetailPresenter`, `UserLocationPresenter`

Unit tested with mock `View` and `Navigator`.

### ViewModel (MVVM)

Defines Interface of `Navigator`

Exposes `Entity` data from `UseCase` to `ViewModel`. `View` is responsible for `Rx` binding.

Exposes `Action` to navigate using `Navigator`.

Example(s): `UserListViewModel`, `UserDetailViewModel`, `UserLocationViewModel`

Unit tested with `RxTest` framework and mock `Navigator`.

## Platform (Executable)
Imports `Presentation`

Imports `Entity`

Implementation of `View` interfaces defined in `Presenter`.

Implementation of `Navigator` interfaces defined in `Presenter`.

Where all of the `Service`'s/`Presenter`'s are configured for the current platform.

Example(s): `iOS`, `tvOS`, `Mac`, `Android`

UI tested/Automation with mock `Service`'s and `DataProvider`'s where necessary.

Unit testing optional.

### UseCaseFactory/Provider (Part of Platform)

Injects `DataTransformer` into `...Service`.

Injects `...Service` into `DataProvider`.

Injects `DataProvider` into `UseCase`.

Injects `UseCase` into `Presenter`.

Provides use cases to `Presenter`.

Unit testing not necessary, no business logic exists in this framework.

### ViewFactory/Configurator (Part of Platform, one for each `View`)

Imports `DataTransformer`

Imports `UseCaseFactory`

Imports `...Service` (whatever services are necessary)

Imports `Presenter`

Injects `View` into `Presenter`.

Injects `Navigator` into `Presenter`.

Injects `UseCase` into `Presenter`.

Responsible for creating a `View`, `Presenter` and `Navigator` and configuring them.

Unit testing not necessary.
