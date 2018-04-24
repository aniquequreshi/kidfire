$('#select').change(function(){
    
            var textarea = $('textarea');
            var select   = $(this).val();
    
            textarea.hide();
    
            if (select == '1'){
              textarea.show();
            }
            if (select == '0'){
              textarea.hide();
            }
    });​

    function snapshotToArray(snapshot) {
      var returnArr = [];

      snapshot.forEach(function (childSnapshot) {
          var item = childSnapshot.val();
          item.key = childSnapshot.key;

          returnArr.push(item);
      });

      return returnArr;
  };

  <textarea id="reportText" readonly></textarea>