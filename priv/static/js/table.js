//object.addEventListener("scroll", myScript);
qi('divTable').addEventListener("scroll", function(e){
  console.log(["scrll",e]);
  let target = e.target;
  update_table(target.scrollTop);
  
});

function update_table(scrll){
  r = qi('table')['data-rid'];
  console.log(r);
  direct(tuple(atom('append_rows'), string('table'), string(r)))
}