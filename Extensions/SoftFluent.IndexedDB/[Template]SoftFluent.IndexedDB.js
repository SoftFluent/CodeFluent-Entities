//[%@ reference name="C:\Program Files (x86)\Reference Assemblies\Microsoft\Framework\.NETFramework\v4.5\System.Core.dll" %]
//[%@ namespace name="System" %]
//[%@ namespace name="System.Linq" %]
//[%@ namespace name="CodeFluent.Model" %]

var context = {};
context.indexedDB = {};
context.indexedDB.db = null;

context.indexedDB.open = function (callback) {
    var version = 11;
    var request = indexedDB.open("[%=Producer.Project.DefaultNamespace%]", version);

    request.onupgradeneeded = function (e) {
        var db = e.target.result;
        e.target.transaction.onerror = context.indexedDB.onerror;
        [%foreach(Entity entity in Producer.Project.Entities){
            string properties = String.Join(", ", entity.Properties.Where(p => !p.IsPersistenceIdentity).Select(p => "\"" + p.Name + "\""));
        %]
        if (db.objectStoreNames.contains("[%=entity.Name%]")) {
            db.deleteObjectStore("[%=entity.Name%]"); 
        }

        var store = db.createObjectStore("[%=entity.Name%]",
			[%foreach(Property property in entity.Properties){%]
			    { keyPath: "[%=property.Name%]" [%=(property.IsPersistenceIdentity?", autoIncrement:	true":"")%] }[%=(entity.Properties.Last()==property?"":",")%]
        //[%}%]
		  );

        //[%}%]
    };

    request.onsuccess = function (e) {
        context.indexedDB.db = e.target.result;
        if (callback !== undefined) callback();
    };

    request.onerror = context.indexedDB.onerror;
};
[%foreach(Entity entity in Producer.Project.Entities){
	string parameters = String.Join(", ", entity.Properties.Where(p => !p.IsPersistenceIdentity).Select(p => p.Name));%]
context.indexedDB.[%=entity.Name%] = {}

context.indexedDB.[%=entity.Name%].add = function ([%= parameters %], callback) {
    var db = context.indexedDB.db;
    var trans = db.transaction(["[%=entity.Name%]"], "readwrite");
    var store = trans.objectStore("[%=entity.Name%]");
    var request = store.put({
	[% 
		foreach (Property property in entity.Properties.Where(p => !p.IsPersistenceIdentity)) {%]
		"[%=property.Name%]": [%=property.Name%], [%}%]
		"timeStamp": new Date().getTime()
});

    request.onsuccess = function (e) {
        callback([%= parameters %],e.srcElement.result);
    };

    request.onerror = function (e) {
        console.log(e);
    };
};

context.indexedDB.[%=entity.Name%].delete = function (id) {
    var db = context.indexedDB.db;
    var trans = db.transaction(["[%=entity.Name%]"], "readwrite");
    var store = trans.objectStore("[%=entity.Name%]");
    var request = store.delete(id);

    request.onsuccess = function (e) {
        //console.log(e);
    };

    request.onerror = function (e) {
        console.log(e);
    };
};

context.indexedDB.[%=entity.Name%].loadAll = function (func) {
    var db = context.indexedDB.db;
    var trans = db.transaction(["[%=entity.Name%]"], "readwrite");
    var store = trans.objectStore("[%=entity.Name%]");

    var keyRange = IDBKeyRange.lowerBound(0);
    var cursorRequest = store.openCursor(keyRange);

    var allResults = [];

    cursorRequest.onsuccess = function (e) {
        var result = e.target.result;
		
        if(!!result == false)
            return func(allResults);

        allResults.push({ id: result.value.Id, text: result.value.Description, done: false });
        result.continue();
    };

    cursorRequest.onerror = function (e) {
        console.log(e);
    };
};
[%}%]

function init() {
    context.indexedDB.open(); // initialize the IndexedDB context.
}

window.addEventListener("DOMContentLoaded", init, false);