// export const data = [
//   {
//     id: 1,
//     imageUrl: 'https://i.imgur.com/9dMc4QG.jpeg',
//     title: 'Муфты Термоусаживаемые и КЗС',
//   },
//   {
//     id: 2,
//     imageUrl: 'https://i.imgur.com/Ma49kLl.jpeg',
//     title: 'ГПИ трубы',
//   },
//   {
//     id: 3,
//     imageUrl: 'https://i.imgur.com/Gn7hQJR.jpeg',
//     title: 'Электронные Счётчики Газа "Гранд"',
//   },
//   {
//     id: 4,
//     imageUrl: 'https://i.imgur.com/6udhzIY.jpeg',
//     title: 'Газовое оборудование, ГРПШ, Фильтра',
//   },
//   {
//     id: 5,
//     imageUrl:
//       'https://i.imgur.com/IO9lvYn.jpeg',
//     title: 'Взрывозащищённое оборудование и КИПиА',
//   },
//   {
//     id: 6,
//     imageUrl:
//       'https://i.imgur.com/IUKiDKn.jpeg',
//     title: 'Сливо-наливное оборудование',
//   },
// ];

function getData() {
  fetch("http://localhost:4000/descriptions?product_id=1")
    .then((response) => {
      if (!response.ok) {
        throw new Error("Error motherfucker!")
      }
      console.log(response, "Resp")
      return response.json();
    })
    .then((data) => {
      console.log(data)
      
      return data;
    })
    .catch((error) => console.error("Fetch error:", error))
};

export const data = getData();
