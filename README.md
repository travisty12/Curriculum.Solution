## Travis' Dopest Curriculum

##### Asp.NET Core MVC / API application, with a many-to-many database

### Description
_This app uses a homemade API to serve lessons and tracks, which have a many-to-many relationship, to views in an MVC app._

### Required Installations
* _MySql_
* _MySqlWorkbench_
* _C# (if on a Mac device)_

### Setup Instructions
* _Create a schema named 'curriculum' (or your choice, updating `appsettings.json` accordingly) using the following steps: ((This might be unnecessary))_
* * _1) Open MySqlWorkbench._
* * _2) Right click on the schemas, select 'Create Schema', name it 'curriculum', and hit 'apply'._
* * _3) run `dotnet ef migrations add {Your Choice}` and `dotnet ef database update` to get the database ready
* _Navigate to the CurriculumApi folder, and run `dotnet watch run` to enable the API to serve data._
* _Navigate to the Curriculum folder, and run `dotnet watch run` to start the MVC application._
* _Navigate to [your localhost at 8080](http://localhost:8080/)_
