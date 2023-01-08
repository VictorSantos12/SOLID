# SOLID

SOLID é um acrônimo formado pelas iniciais dos cinco principios da programação orientada a objetos, criado pelo desenvolvedor e escritor [Michael Feathers](https://i1.sndcdn.com/artworks-uuCAD9dOPcSo7U1b-pMBJ6Q-t500x500.jpg), após este constatar que os principais conceitos da POO descritos por Bobert C. Martin formam a palavra <i>SOLID</i>.

Abordados no artigo [The Principles of OOD](http://butunclebob.com/ArticleS.UncleBob.PrinciplesOfOod), os conceitos mencionados se tornaram um padrão quando se trata de desenvolvimento de sistemas baseados em objetos, sendo este um método adotado por praticamente todos os sistemas existentes hoje.

# S.O.L.I.D

Os principios descritos por Feathers consistem em:

## S (Single Responsability Principle)

O SRP, define que à uma classe só se deve delegadar uma função. Classes que exercem multiplas tarefas são bastante comuns no inicio do processo de aprendizado de um desenvolvedor. As chamadas <i>God Classes</i> são um sinal de que o código necessita de uma reestruturação, caso contrário, não demorará muito para se perder o controle e a legibilidade do que foi desenvolvido. 

Um outro problema que ocorre com classes acumuladoras de funções, é a dificultade de manutenir suas responsabilidades, visto que mudanças em determinadas funções, poderão comprometer as outras. Com isso, toda alteração passa a ser vista com incerteza, já que poderá resultar em problemas em um código já operante.

> God Class: Na programação orientada a objetos, é uma classe que sabe demais ou faz demais.

Exemplo:
    
    // .dart

    class Order {
    
       void calculateTotalSum(){}
       void getItems(){}
       void getItemCount(){}
       void addItem($item){}
       void deleteItem($item){}  
       
       void printOrder(){}
       void showOrder(){}  
       
       void load(){}
       void save(){}
       void update(){}
       void delete(){}
    
    }

A classe acima é um exemplo claro da quebra do SRP, pois a ela são delegadas três diferentes tipos de terafas. Sendo responsável pela obtenção dos dados, não é coerente que também se responsabilize por apresentar os resultados e pela manutenção das informações. A delegação de tais tarefas a classes, estaria respeitando o princípio de responsabilidade única caso fosse estruturada da seguinte forma:

    // .dart

    class Order {
    
       void calculateTotalSum(){}
       void getItems(){}
       void getItemCount(){}
       void addItem($item){}
       void deleteItem($item){}  
    
    }

    class OrderRepository {
       
       void load(orderId){}
       void save(order){}
       void update(order){}
       void delete(order){}
    
    }

    class OrderViewer {
       
       void printOrder(){}
       void showOrder(){}  
    
    }

É notavel o crescimento em termos de linhas de código, visto que para cada funcionalidade, uma classe foi criada. A primeira vista, tal crescimento pode aparentar um problema, já que é lógico afirmar que: mais código significa mais trabalho. Porém, não é o caso. Dar manutenção as funcionalidades a partir de classes distintas se torna muito mais simples, pois, nenhuma das demais tarefaz serão afetadas por quais quer que sejam as mudanças.

Além disso, cabe resaltar que o principio de responsabilidade única não se restringe a classes. Métodos e funções também executam tarefas e também podem acabar sobrecarregadas. 

Exemplo:

    // .dart

    void emailClients(List<dynamic> clients) {
        for(client in clients) {
            final clientRecord = db.contains(client);
            if(clientRecord['isActive']) {
              email(client);
            }
        }  
    }

É possível notar três tarefas distintas executadas em um único método. Para que estas estejam dentro dos parâmetros do SRP, cada tarefa deveria estar contida em um método próprio:
    
    // .dart

    void emailClients(List<Client> clients) {
      final activeClients = getActiveClients(clients);
    }

    List<Client> getActiveClients(List<Client> clients) {
       List<Client> activeClients = [];
       
       activeClients = clients.map((client) => isClientActive(client)) as List<Client>;

       return activeClients;
    }

    void isClientActive(Client client) {
       final clientRecord = db.contains(client); 
    }

Novamento, o resultado implica na quantidade de código necessário, porém, resulta em muito mais legibilidade e, por consequência, em um código mais limpo.

## O (Open-Closed Principle)

## L (Liskov Substitution Principile)

## I (Interface Segregation Principle)

## D (Dependency Inversion Principle)

## Por que o SOLID ?