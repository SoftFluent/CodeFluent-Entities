////////
var context = {};
context.indexedDB = {};
context.indexedDB.db = null;

context.indexedDB.open = function (callback) {
    var version = 13;
    var request = indexedDB.open("SoftFluent.Samples.CordovaTodoMobile", version);

    request.onupgradeneeded = function (e) {
        var db = e.target.result;
        e.target.transaction.onerror = context.indexedDB.onerror;
        
        if (db.objectStoreNames.contains("Task")) {
            db.deleteObjectStore("Task"); 
        }

        var store = db.createObjectStore("Task",
			
			    { keyPath: "Id" },
        //
			    { keyPath: "Description" }
        //
		  );

        //
    };

    request.onsuccess = function (e) {
        context.indexedDB.db = e.target.result;
        if (callback !== undefined) setTimeout(function(){ callback(); }, 200);
    };

    request.onerror = context.indexedDB.onerror;
};

context.indexedDB.Task = {}

context.indexedDB.Task.add = function (Id, Description) {
    var db = context.indexedDB.db;
    var trans = db.transaction(["Task"], "readwrite");
    var store = trans.objectStore("Task");
    var request = store.put({
	
		"Id": Id, 
		"Description": Description, 
		"timeStamp": new Date().getTime()
		});
        
    request.onsuccess = function (e) {
        //console.log(e);      
    };

    request.onerror = function (e) {
        alert('add error');
        console.log(e);
    };
};

context.indexedDB.Task.delete = function (id) {
    var db = context.indexedDB.db;
    var trans = db.transaction(["Task"], "readwrite");
    var store = trans.objectStore("Task");
    var request = store.delete(id);

    request.onsuccess = function (e) {
        //console.log(e);
    };

    request.onerror = function (e) {
        console.log(e);
    };
};

context.indexedDB.Task.loadAll = function (callback) {
    var db = context.indexedDB.db;
    var trans = db.transaction(["Task"], "readwrite");
    var store = trans.objectStore("Task");

    var keyRange = IDBKeyRange.lowerBound(0);
    var cursorRequest = store.openCursor(keyRange);

    var allResults = [];

    cursorRequest.onsuccess = function (e) {
        var result = e.target.result;
		
        if(!!result == false)
            return callback(allResults);

        allResults.push({ id: result.value.Id, text: result.value.Description, done: false });
        result.continue();
    };

    cursorRequest.onerror = function (e) {
        console.log(e);
    };
};


function init() {
    context.indexedDB.open(); // initialize the IndexedDB context.
}

window.addEventListener("DOMContentLoaded", init, false);