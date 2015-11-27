CodeFluent Entities Documentation
===================

Create high-quality software always aligned with your business
----------------------------------
CodeFluent Entities is a product integrated into Visual Studio that allows you to create your application foundations. Minimize heavy plumbing work and internal framework development by generating your data access layers. Keep your business sync with your software implementations and focus on what makes the difference.

----------


Model your business
-------------
Leverage the centralized platform-independent model describing your business application thanks to the Visual Studio integrated Modeler.

**Model-First**: Transform your business into a model using a natural and visual modeling approach. You don't need to learn anything to start.

**Visual Studio Integration**: The graphical modeler is fully integrated in Microsoft Visual Studio (from 2008 to 2015).

**Application-wide**: Apply application-wide changes in a few clicks such as cache and naming conventions.

**Absorb functional changes**: Improve your agility by accepting model changes at any time.

**Import your database**: Create your model in minutes by importing your existing database schema and data.

Define your foundations
-------------
From your business model, CodeFluent Entities generates Transact-SQL scripts and C# code. Focus on what makes the difference.

IMAGE ??

**Human-readable**: No code generated at runtime, everything is human-readable and can be changed if needed.

**Reduce dependencies**: Minimize heavy plumbing work and internal framework development.

**Continuously generate**: Update your model and ensure consistency across all layers.

**Minimize risk**: Less manual code means fewer bugs and effortless maintenance.

**Extensibility**: Generated code is composed of partial classes. Extending it is nothing more than standard .NET development.

**Incremental updates**: The Microsoft SQL Server differential engine enables hassle-free schema updates without losing any data.

Develop your application
-------------
Create your application by using the generated data access layer composed of .NET classes.

**Simple and reliable**: CRUD operations and validation are supported out-of-the-box and without a single line of code.

**Paginate your data**: All the loading methods support server-side paging.

**Data Access Layer**: Simplified access to data stored in your SQL Server storage.

**Database sorting**: Sorting is done in the persistence layer to ensure optimal performances.

    Customer customer = Customer.LoadbyName("Contoso");
        
    customer.IsProspect = false;
    
    customer.Save();