import './scss/App.scss';
import Header from './components/Header/Header';
import Content from './components/Content/Content';
import Footer from './components/Footer/Footer';
import About from './components/About/About';
import Product from './components/Product/Product';

import { Route, Routes } from 'react-router-dom';

function App() {
  return (
    <div className='root'>
      <Header />
      <Routes>
        <Route path='/*' element={<Content />} />
        <Route path='/about' element={<About />} />
        <Route path='/product' element={<Product />} />
      </Routes>
      <Footer />
    </div>
  );
}

export default App;
