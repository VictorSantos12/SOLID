<div align="center">
  <img src="https://user-images.githubusercontent.com/61476935/211217154-0ca03369-8f7e-4771-bda1-f32b40f91a8a.png">
</div>
<br>

SOLID é um acrônimo formado pelas iniciais dos cinco princípios da programação orientada a objetos, criado pelo desenvolvedor e escritor [Michael Feathers](https://i1.sndcdn.com/artworks-uuCAD9dOPcSo7U1b-pMBJ6Q-t500x500.jpg) após este constatar que os principais conceitos da POO descritos por Bobert C. Martin formam a palavra <i>SOLID</i>.

Abordados no artigo [The Principles of OOD](http://butunclebob.com/ArticleS.UncleBob.PrinciplesOfOod), os conceitos mencionados se tornaram um padrão quando se trata de desenvolvimento de sistemas baseados em objetos, sendo este um método adotado por praticamente todos os sistemas existentes hoje. 

Os princípios descritos por Feathers consistem em:

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

A classe acima é um exemplo claro da quebra do SRP, pois a ela são delegadas três diferentes tipos de tarefas. Sendo responsável pela obtenção dos dados, não é coerente que também se responsabilize por apresentar os resultados e pela manutenção das informações. A delegação de tais tarefas a classes, estaria respeitando o princípio de responsabilidade única caso fosse estruturada da seguinte forma:

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

É notavel o crescimento em termos de linhas de código, visto que uma classe foi criada para cada funcionalidade. A primeira vista, tal crescimento pode aparentar um problema, já que é lógico afirmar que mais código significa mais trabalho. Porém, não é o caso. Dar manutenção as funcionalidades a partir de classes distintas se torna muito mais simples, pois, nenhuma das demais tarefaz serão afetadas por quais quer que sejam as mudanças.

Além disso, cabe resaltar que o princípio de responsabilidade única não se restringe a classes, métodos e funções também executam tarefas e também podem acabar sobrecarregadas. 

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

O princípio Open-Closed define que <i>entidades e objetos devem estar propensos a serem extendidos, mas hostis a modificações</i>, ou seja, ao surgir a necessidade de adicionar novos requisitos e funcionalidades em um software, deve-se optar por estender o que já foi desenvolvido e evitar modificações.

Exemplo: 

    // .dart

    class CLT {
      laborRights() {
         print('Labor Rights');
      }
    }
    
    class PJ {
      biggerSalary() {
        print('Bigger Salary');
      }
    }
    
    class Benefits {
      
      dynamic benefits;
    
      void defineBenefits(contractType) {
        if(contractType is CLT) {
    
          final contract = CLT();
          benefits = contract.laborRights();
    
        } else if(contractType is PJ) {
          
          final contract = PJ();
          benefits = contract.biggerSalary();

        }
      }
    }

O exemplo acima simula o fluxo de definição de benefícios que diferentes tipos de contração possuem, representados pelas classes CLT e PJ, onde cada classe opera seu respectivo benefício através de um método único. Além disso, há uma terceira classe que opera e define os benefécios por tipo de contrato. 

Contudo, caso a empresa que usa esse sistema viesse a decidir por contratar estagiários, uma intervenção na classe Benefits seria necessária, pois ela precisaria validar um tipo não esperado de contrato. Esse problema demonstra explícitamente uma quebra do OCP, pois, uma classe já operante teria que ter sua regra de negócio modificada para se adequar a uma nova funcionalidade. 

Tal alteração pode parecer o caminho mais fácil e certamente seria aderido por desenvolvedores menos experientes. No entanto, se cada modificação futura se valer por uma alteração no código fonte, abre-se espaço para bugs e o mau funcionamento de uma rotina já implementada. De forma alternativa, podemos seguir a solução descrita por Robert C. Martin para resolver tal problemática:

### <i>"Separate extensible behavior behind an interface, and flip the dependencies".</i> 
- Martin, C. Robert

Com isso se conclui que comportamentos não derivativos podem ser abstraídos para que uma solução não necessite implementá-los multiplas vezes. Se observarmos o que ocorre em cada classe que define um tipo de contrato do sistema de benefícios, é exatamente o que ocorre. Logo, criar uma interface que será implementada por cada cargo fará com que a classe Benefits não tenha que se preocupar com que cargo ela está tratando, mas sim com a interface que este implementa. Interface esta que pode ser implementada por qualquer cargo que venha a compor o sistema.

Exemplo:

    // .dart

    abstract class Benefit {
      contractBenefits();
    }
    
    class CLT implements Benefit {
      @override
      contractBenefits() {
         print('Labor Rights');
       }
    }
    
    class PJ implements Benefit {
      @override
      contractBenefits() { 
        print('Bigger Salary');
      }
    }
    
    class Trainee implements Benefit {
      @override
      contractBenefits() { 
        print('Less responsibilities');
      }
    }
    
    class Benefits {
      
      void defineBenefits(Benefit contractType) {
        contractType.contractBenefits();
      } 
    }
    
    void main() {
      final cltBenefits = Benefits().defineBenefits(CLT());
      final pjBenefits = Benefits().defineBenefits(PJ());
      final traineeBenefits = Benefits().defineBenefits(Trainee());  
    }

A classe Benefit declara o método contractBenefits(), que será obrigatoriamente implementado por todos os contratos. Com isso, podemos fazer com que o método defineBenefits() sempre espere por uma implementação da interface Benefit, tornando modificações algo desnecessário, e permitindo a criação de quantos tipos de contrato forem necessários, incluíndo o definido pela classe <i>Trainee(estagiário)</i>.

## L (Liskov Substitution Principle)

Introduzido pela cientista da computação [Barbara Liskov](https://en.wikipedia.org/wiki/Barbara_Liskov) em 1987, o princípio de substituição de Liskov define que <i>uma classe herdeira deve poder ser subtituída pela classe da qual ela herda sem que haja a necessidade de altera programas que a implementem.</i> Sua definição formal diz:

### <i>Se para cada objeto o1 do tipo S há um objeto o2 do tipo T de forma que, para todos os programas P definidos em termos de T, o comportamento de P é inalterado quando o1 é substituído por o2 então S é um subtipo de T</i>

Para facilitar o entendimento, vamos a um exemplo: 
    
    // .dart

    class Super {
      method() {
        print('Super Object');
      }
    }
    
    class Sub extends Super{
      method() {
        print('Sub Object');
      }
    }
    
    final superObject = Super();
    final subObject = Sub();
    
    void operation(Super object) {
       object.method();
    }
    
    main() {
      operation(superObject);
      operation(subObject);
    }

A operação, definida pelo método operation() declara a aceitação da classe <i>Super</i> como parâmetro, logo, quaisquer classes que dela herdem também devem poder ser aceitas na operação sem que ocorra qualquer erro. Output:

    [Running] dart "c:\SOLID\main.dart"
    Super Object
    Sub Object

Pode-se dizer que se o conceito de inheritance da OOP for bem compreendido, você dificilmente não estará seguindo a LSP. No entanto, você não está atendendo ao princípio de substituição de Liskov quando:

### Sobrescreve métodos que não possuem função:

    class Sub extends Super {
      method() {
         // no function
      }
    }

### Lança exceções inesperadas:
  
    class Sub extends Super {
      method() {
        if (true) {
          throw Exception();
        }
        // do something
      }
    }

### Retornar valores de tipos distintos:

    class Super {
      method() {
        // do something
        return true;
      }
    }

    class Sub extends Super {
      method() {
        // do something
        return "true";
      }
    }

A não violação do LSP demanda experiência prévia com a programação orientada a objetos e conehcimento dos demais conceitos do SOLID, visto que as abstrações devem ser bem planejadas. Com isso, o LSP permite que o polimorfismo nas suas classes seja feito com muito mais certeza quando aplicado.

## I (Interface Segregation Principle)



## D (Dependency Inversion Principle)

## Por que o SOLID ?