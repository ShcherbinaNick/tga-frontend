import './scss/App.scss';
import Header from './components/Header/Header';
import Content from './components/Content/Content';
import Footer from './components/Footer/Footer';
import About from './components/About/About';
import Product from './components/Product/Product';
import React from 'react';

import { Route, Routes } from 'react-router-dom';

function App() {
  const [data, setData] = React.useState([]);

  React.useEffect(() => {
    fetch('https://inuenisse.serveo.net/products')
      .then((res) => res.json())
      .then((dataArr) => {
        setData(dataArr);
      })
      .catch((err) => console.log(`Ошибка: ${err}`));
  }, []);

  return (
    <div className='root'>
      <Header />
      <Routes>
        <Route path='/*' element={<Content data={data} />} />
        <Route path='/about' element={<About />} />
        <Route path='/product' element={<Product />} />
      </Routes>
      <Footer />
    </div>
  );
}

export default App;
