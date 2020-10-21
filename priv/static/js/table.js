//object.addEventListener("scroll", myScript);
qi('divTable').addEventListener("scroll", function(e){
  console.log(["scrll",e]);
  let target = e.target;
  update_table(target.scrollTop);
  
});

function update_table(scrll){
  r = qi('table')['data-rid'];
  console.log([scrll, 10 + scrll + qi('divTable').offsetHeight, qi('table').offsetHeight ]);
  
  if(scrll + qi('divTable').offsetHeight + 10 > qi('table').offsetHeight ){
    direct(tuple(atom('append_rows'), string('table'), string(r)))
  }
  
}