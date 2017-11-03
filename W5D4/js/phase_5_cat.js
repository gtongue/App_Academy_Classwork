const Cat = function Cat(name, owner){
  this.name = name;
  this.owner = owner;
};

Cat.prototype.cuteStatement = function cuteStatement()
{
  return `${this.owner} loves ${this.name}`;
};
