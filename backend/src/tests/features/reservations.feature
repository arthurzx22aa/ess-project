Feature: Create reservations

    Creating the reservations and posting them in the db

Scenario: Criar uma reserva de uma acomodação existente com sucesso
    Given existe uma acomodação com accommodation_id "be7cf4d8-f408-41e7-85f2-920b5be751c4" no banco de dados
    And adiciona-se os dados da reserva nos campos: checkin: "2024-02-20", checkout: "2024-02-22", client_id: "pedro123", accommodation_id: "be7cf4d8-f408-41e7-85f2-920b5be751c4"
    When uma requisição "POST" for enviada para "/reservation/create"
    Then o status da resposta a ser mostrada é "200"
    And a resposta deve conter a mensagem "Accommodation created successfully!"

Scenario: Criar uma reserva de uma acomodação inexistente
    Given não existe uma acomodação com id "aaaaaaaaaa"
    And adiciona-se os dados da reserva nos campos: checkin: "2024-02-20", checkout: "2024-02-22", client_id: "pedro123", accommodation_id: "be7cf4d8-f408-41e7-85f2-920b5be751c4"
    When uma requisição "POST" for enviada para "/reservation/create"
    Then Then o status da resposta a ser mostrada é "404"
    And a resposta deve conter a mensagem "Accommodation not found"

Scenario: Criar uma reserva com cliente inexistente no banco de dados
    Given não existe um cliente cuja id é "lucinda456"
    And adiciona-se os dados da reserva nos campos: checkin: "2024-02-20", checkout: "2024-02-22", client_id: "lucinda456", accommodation_id: "be7cf4d8-f408-41e7-85f2-920b5be751c4"
    When uma requisição "POST" for enviada para "/reservation/create"
    Then o status da resposta a ser mostrada é "404"
    And a resposta deve conter a mensagem "Client not found"

Scenario: Criar uma reserva com data de checkin depois da data de checkout 
    Given existe uma acomodação com accommodation_id "be7cf4d8-f408-41e7-85f2-920b5be751c4" no banco de dados
    And adiciona-se os dados da reserva nos campos: checkin: "2024-02-24", checkout: "2024-02-22", client_id: "pedro123", accommodation_id: "be7cf4d8-f408-41e7-85f2-920b5be751c4"
    When uma requisição "POST" for enviada para "/reservation/create"
    Then o status da resposta a ser mostrada é "400"
    And a resposta deve conter a mensagem "Check-out date must be after check-in date"

Scenario: Criar uma reserva de um cliente cuja id é a mesma daquele que criou a acomodação
    Given existe uma acomodação com accommodation_id "be7cf4d8-f408-41e7-85f2-920b5be751c4" no banco de dados
    And aquele que criou a acomodação tem id "yasmin123"
    And adiciona-se os dados da reserva nos campos: checkin: "2024-02-20", checkout: "2024-02-22", client_id: "yasmin123", accommodation_id: "be7cf4d8-f408-41e7-85f2-920b5be751c4"
    When uma requisição "POST" for enviada para "/reservation/create"
    Then o status da resposta a ser mostrada é "400"
    And a resposta deve conter a mensagem "Client cannot reserve their own accommodation"

Scenario: Criar uma reserva com, pelo menos, uma das datas escolhidas indisponíveis
    Given existe uma acomodação com accommodation_id "be7cf4d8-f408-41e7-85f2-920b5be751c4" no banco de dados
    And adiciona-se os dados da reserva nos campos: checkin: "2024-02-20", checkout: "2024-02-29", client_id: "pedro123", accommodation_id: "be7cf4d8-f408-41e7-85f2-920b5be751c4"
    When uma requisição "POST" for enviada para "/reservation/create"
    Then o status da resposta a ser mostrada é "400"
    And a resposta deve conter a mensagem "Chosen date already reserved"


